# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rgen/rgen-0.6.6.ebuild,v 1.1 2013/10/31 06:51:41 graaff Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 "

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Ruby Modelling and Generator Framework"
HOMEPAGE="https://github.com/mthiede/rgen"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

each_ruby_test() {
	${RUBY} -S testrb $(find test -type f -name '*_test.rb') || die
}
