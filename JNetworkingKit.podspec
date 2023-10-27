Pod::Spec.new do |s|
  s.name    = "JNetworkingKit"
  s.version = "4.1.0"
  s.summary = "A generic networking setup for Swift and Objective-C."
  s.license = {
    :type => 'MIT', :text => <<-LICENSE
      MIT License

      Copyright (c) 2018 Jumbo Tech Campus

      Permission is hereby granted, free of charge, to any person obtaining a copy
      of this software and associated documentation files (the "Software"), to deal
      in the Software without restriction, including without limitation the rights
      to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
      copies of the Software, and to permit persons to whom the Software is
      furnished to do so, subject to the following conditions:

      The above copyright notice and this permission notice shall be included in all
      copies or substantial portions of the Software.

      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
      SOFTWARE.
    LICENSE
  }

  s.author           = "Jumbo"
  s.homepage         = "https://www.jumbo.com/"
  s.social_media_url = "https://twitter.com/jumbotechcampus"

  s.swift_version = '4.2'
  s.platform      = :ios, "14.0"
  s.source        = { :git => "https://github.com/jumbo-tech-campus/JNetworkingKit.git", :tag => "#{s.version}" }
  s.source_files  = "JNetworkingKit/Source/**/*.{swift}"
end
