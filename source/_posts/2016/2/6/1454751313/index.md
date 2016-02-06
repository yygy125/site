title: 面向对象的理解
---
关于PHP面向对象的理解与实现

先说说日常中接触的面向对象(仅针对我本身)，工作两年来，接触了不多不少的项目，多为ThinkPHP所构建，真是多得他不少，大部分所谓的面向对象，就是一个个的类(然而这里并没有什么问题)，但是，一个类里面却充当着 A，同时又充当着 B。

后台也逐渐地了解到，面向对象，并不是这样写的。

首先要知道面向对象的特质，说说我的理解什么 **高内聚，低耦合** 这些就不说了

1.  单一职责，一个类只做一件事，这个是最基础的了
2.  开闭原则，也就是，一个类，不应该是固定的，而是应该灵活扩展的
3.  面向接口，关注接口，而非具体实现

简单说了以上几点，这是我的理解。

而且我会把一系列的类，都会放在一个属于他们的地方当中，不会影响或者依赖其他的类库。

一下做一些理解说明：

### 单一职责

何谓单一职责，也就是说一个类只需要做好它本身的工作，不需要关心外界的实现，也不需要别人知道我内部怎么实现的，明确职责后，就针对该职责专门实现即可。

例如：

定义个输出类:

    <?php

    class Output
    {
        public function println($message)
        {
            echo $message;
        }
    }

这个类也很简单，就是负责你的输出，但是输出之前可能会接受不同的输入来确定输出的内容，但是输出并不在他的职责范围内，所以此时要多定义个接受输入的类.

    <?php

    class Input
    {
        protected $message;
        public function setInput($message)
        {
            $this->message = $message;
        }

        public function getInput()
        {
            return $this->message;
        }
    }

示例使用：

    $input = new Input();
    $input->setInput('jan');

    $output = new Output();
    $output->println($input->getInput());

所以两者职责应该分开，如果需要输入输出，应该是需要一个管理类对象去管理和调度两者，不应该两者之间有直接的关联。

### 开闭原则

开闭原则说白了也就是，写的类应该可以继承啊，扩展等等之类的，并不是一成不变的。

    class Output
    {
        public function println($message)
        {
            echo $message;
        }
    }

如上，如果一个普通的输出类完全不能满足当前你的要求，你完全可以扩展它，但是不是修改他。

    class MyOutput extends Output
    {
        public function setColor($message, $color)
        {
            return '<font color="' . $color . '">' . $message . '</font>';
        }

        public function println($message)
        {
            parent::println($this->setColor($message, 'red'));
        }
    }

以上就可以完全不需要修改源代码，直接扩展得到自己想要的。当然如果是开源的工具，如果有更好的建议完全可以提交issue给开发者，提高代码质量是每个人都应该做的事情。

### 面向接口

面向接口也就是咱们的 `interface` ，其实在面向对象中，很多人其实都知道 `abstract`, `interface` 怎么用，但是并不知道用在哪里，特别在哪些坑爹学校读书的时候，估计老师都不知道呢，呵呵哒。

面向接口，什么是面向接口，怎么面向法。

其实也很简单，先把一个具体要实现的类抽象化先，因为每个类的方法可能都会调整，那么其实确定是这样子，应该优先调整接口。

怎么练习呢？

*   首先要知道你实现的类有什么特点，
*   根据特点定义对应的抽象方法

比如：输出

简单的。就当只有一个输出功能(当然还有很多，这个自己摸搜下)

那这里就可以定义一个输出的抽象方法

    <?php

    interface OutputInterface
    {
        public function println($message);
    }

这样就可以简单的完成一个抽象的方法设计了。

举个例子：

    <?php

    interface OutputInterface
    {
        public function println($message);
    }

    class BaseOutput implements OutputInterface
    {
        public function println($message)
        {
            echo 'base: ' . $message;
        }
    }

那么这里如果我想要使用输出类，其实可以按照之前的方法，直接通过 `new` 的方法实现，也可以通过继承的方法扩展修改。

但是如果我此刻内部有一个管理的类对象，那就不应该使用这些硬编码的形式去做了。

例如，现在我又多了一个 `ColorOutput` 对象。

    <?php

    class ColorOutput implements OutputInterface
    {
        public function println($message)
        {
            echo 'Color: ' . $message;
        }
    }

管理类，传统的做法是：

    <?php

    class OutputManager
    {
        const OUTPUT_BASE = 1;
        const OUTPUT_COLOR = 2;
        public function output($message, $output = OutputManager::OUTPUT_BASE)
        {
            switch ($output) {
                case OutputManager::OUTPUT_BASE:
                    $output = new BaseOutput();
                    break;
                case OutputManager::OUTPUT_COLOR:
                    $output = new ColorOutput();
                    break;
                default:
                    throw new Exception('en o shit.');
            }

            $output->println($message);
        }
    }

传统的做法就是这样子，通过判断，但是如果我有很多个，那就意味着，我要定义很多个参数，很多个判断。

但是其实这里可以灵活的设置 `$output` 为一个抽象对象参数约束，用来约束传入的类。这也就是达到了灵活的效果。稍微改造一下。

    <?php

    class OutputManager
    {
        public function output($message, OutputInterface $output)
        {
            $output->println($message);
        }
    }

使用:

    <?php

    $manager = new OutputManager();
    $manager->output('demo', new ColorOutput());
    $manager->output('demo', new BaseOutput());

这样就可以减少很多的判断，也可以使你代码的逼格有所提升，但最重要的是，你学会了这样设计，基于面向接口的形式去做，提高了对象的灵活度，降低了对象与对象直接的耦合，也理解了对象的单一职责。

#### 当然对于以上解析其实还有些不是说的很清楚，表达的不是太好，所以还需要大家多花时间思考日常接触到的。多融入生活理解。

