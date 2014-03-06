# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/httparty/httparty-0.13.0.ebuild,v 1.1 2014/03/06 16:14:25 mrueg Exp $

EAPI=5

# jruby → testsuite fails (seems like a testuite bug)
USE_RUBY="ruby18 ruby19"

# We have a custom test function, but don't null this out so that the
# deps are still added
RUBY_FAKEGEM_TASK_TEST="none"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md History"

inherit ruby-fakegem

DESCRIPTION="Makes http fun! Also, makes consuming restful web services dead easy."
HOMEPAGE="http://httparty.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

ruby_add_rdepend '=dev-ruby/multi_json-1* >=dev-ruby/multi_xml-0.5.2'

ruby_add_bdepend 'dev-ruby/rspec:0 dev-ruby/fakeweb'

all_ruby_prepare() {
	# Remove bundler
	rm Gemfile || die
	sed -i -e '/[Bb]undler/ s:^:#:' Rakefile || die

#	sed -i -e '/git ls-files/ s:^:#:' ${PN}.gemspec || die
}

each_ruby_test() {
	${RUBY} -S rake spec || die
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/*
}
