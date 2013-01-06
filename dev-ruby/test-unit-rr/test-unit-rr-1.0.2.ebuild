# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/test-unit-rr/test-unit-rr-1.0.2.ebuild,v 1.7 2012/12/30 16:56:35 armin76 Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="RR adapter for Test::Unit."
HOMEPAGE="http://rubyforge.org/projects/test-unit/"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/rr-1.0.2 >=dev-ruby/test-unit-2.5.2"

each_ruby_test() {
	${RUBY} test/run-test.rb || die
}
