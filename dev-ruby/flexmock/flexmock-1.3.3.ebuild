# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/flexmock/flexmock-1.3.3.ebuild,v 1.5 2015/03/20 13:56:41 graaff Exp $

EAPI=5
# ruby22 -> fails specs
USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_DOCDIR="html"
RUBY_FAKEGEM_EXTRADOC="CHANGES README.md doc/*.rdoc doc/releases/*"

RUBY_FAKEGEM_RECIPE_TEST="none"
RUBY_FAKEGEM_RECIPE_DOC="none"

inherit ruby-fakegem

DESCRIPTION="Simple mock object library for Ruby unit testing"
HOMEPAGE="https://github.com/jimweirich/flexmock"

LICENSE="flexmock"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_bdepend "
	test? (
		dev-ruby/rspec:2
	)"

each_ruby_test() {
	ruby-ng_rspec test/rspec_integration
	${RUBY} -S testrb -Ilib:. test/*_test.rb || die
}
