# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Olson-Abbreviations/Olson-Abbreviations-0.30.0.ebuild,v 1.1 2012/11/18 19:23:31 tove Exp $

EAPI=4

MODULE_AUTHOR=ECARROLL
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="Globally unique timezones abbreviation handling"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Moose
	>=dev-perl/MooseX-ClassAttribute-0.250.0
	dev-perl/namespace-autoclean
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
	)
"

SRC_TEST=do

src_prepare() {
	mv t/pod-coverage.t{,.disable}
	perl-module_src_prepare
}
