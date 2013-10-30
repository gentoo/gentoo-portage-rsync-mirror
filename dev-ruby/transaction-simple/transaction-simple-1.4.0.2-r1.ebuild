# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/transaction-simple/transaction-simple-1.4.0.2-r1.ebuild,v 1.1 2013/10/30 03:57:00 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_TEST="none"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.rdoc README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Provides transaction support at the object level"
HOMEPAGE="http://rubyforge.org/projects/trans-simple/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend "
	test? (
		>=dev-ruby/test-unit-2.5.1-r1
	)
	doc? ( dev-ruby/hoe )"

each_ruby_test() {
	ruby-ng_testrb-2 -Ilib test/test_*.rb
}
