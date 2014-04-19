# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/transaction-simple/transaction-simple-1.4.0.2.ebuild,v 1.6 2014/04/19 03:16:52 mrueg Exp $

EAPI=4
USE_RUBY="ruby19"

RUBY_FAKEGEM_RECIPE_TEST="none"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Provides transaction support at the object level"
HOMEPAGE="http://rubyforge.org/projects/trans-simple/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

ruby_add_bdepend "
	test? (
		>=dev-ruby/test-unit-2.5.1-r1
	)
	doc? ( dev-ruby/hoe )"

each_ruby_test() {
	ruby-ng_testrb-2 -Ilib test/test_*.rb
}
