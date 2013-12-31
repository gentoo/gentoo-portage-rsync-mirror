# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/i18n/i18n-0.6.9-r1.ebuild,v 1.1 2013/12/25 09:43:34 graaff Exp $

EAPI=5

USE_RUBY="ruby18 jruby ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_TEST="test"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.textile"

inherit ruby-fakegem

DESCRIPTION="Add Internationalization support to your Ruby application."
HOMEPAGE="http://rails-i18n.org/"

LICENSE="MIT"
SLOT="0.6"
KEYWORDS="~amd64 ~arm"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/activesupport
	dev-ruby/mocha:0.12
	dev-ruby/test_declarative )"

each_ruby_test() {
	${RUBY} -w -Ilib -Itest test/all.rb || die
}

all_ruby_prepare() {
	#Bundler isn't really necessary here, and it doesn't work with jruby
	#Tests fail for ruby18 with >=mocha-0.13
	sed -i -e "15s/require 'bundler\/setup'//"\
		-e "/require 'mocha'/i gem 'mocha', '~>0.12.0'" test/test_helper.rb || die
}
