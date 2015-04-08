# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/colorize/colorize-0.7.5.ebuild,v 1.2 2015/03/05 06:02:51 graaff Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.md"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="Add some methods to set color, background color and text effect on console easier"
HOMEPAGE="https://github.com/fazibear/colorize"
LICENSE="GPL-2+"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

each_ruby_test() {
	cd test || die
	${RUBY} test_colorize.rb || die
}
