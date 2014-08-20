# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tilt/tilt-2.0.1.ebuild,v 1.1 2014/08/20 19:37:47 graaff Exp $

EAPI=5

# jruby fails tests
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md docs/TEMPLATES.md"

inherit ruby-fakegem

DESCRIPTION="A thin interface over a Ruby template engines to make their usage as generic as possible"
HOMEPAGE="http://github.com/rtomayko/tilt"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

# Block on some of the potential test dependencies. These dependencies
# are optional for the test suite, and we don't want to depend on all of
# them to faciliate keywording and stabling.
ruby_add_bdepend "test? (
	dev-ruby/bluecloth
	dev-ruby/coffee-script
	dev-ruby/erubis
	dev-ruby/nokogiri
	dev-ruby/radius
	!!<dev-ruby/maruku-0.7.2 )"

# Most dependencies are optional: skip haml for ruby20 and ruby21
# because haml depends on rails.
USE_RUBY="ruby19" ruby_add_bdepend "test? ( dev-ruby/haml )"

ruby_add_rdepend ">=dev-ruby/builder-2.0.0"

all_ruby_prepare() {
	rm Gemfile || die
	sed -e '/bundler/I s:^:#:' -i Rakefile test/test_helper.rb || die

	# Avoid tests with minor syntax differences since this happens all
	# the time when details in the dependencies change.
	sed -e '/test_smarty_pants_true/,/^    end/ s:^:#:' -i test/tilt_markdown_test.rb || die
	sed -e '/smartypants when :smart is set/,/^    end/ s:^:#:' -i test/tilt_rdiscounttemplate_test.rb || die
}
