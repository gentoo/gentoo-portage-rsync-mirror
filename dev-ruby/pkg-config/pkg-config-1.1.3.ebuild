# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pkg-config/pkg-config-1.1.3.ebuild,v 1.7 2014/04/05 23:25:14 mrueg Exp $

EAPI="2"
USE_RUBY="ruby19"

RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_TASK_TEST="none"

inherit ruby-fakegem

DESCRIPTION="A pkg-config implementation by Ruby"
HOMEPAGE="https://github.com/rcairo/pkg-config"
LICENSE="|| ( LGPL-2 LGPL-2.1 LGPL-3 )"

KEYWORDS="amd64 ppc ppc64 x86"
SLOT="0"
IUSE=""

# Requires rcairo to be installed.
RESTRICT="test"

each_ruby_test() {
	${RUBY} test/run-test.rb || die
}
