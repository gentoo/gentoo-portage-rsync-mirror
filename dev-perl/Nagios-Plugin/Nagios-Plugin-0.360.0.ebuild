# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Nagios-Plugin/Nagios-Plugin-0.360.0.ebuild,v 1.4 2012/12/06 04:13:37 phajdan.jr Exp $

EAPI=4

MODULE_AUTHOR=TONVOON
MODULE_VERSION=0.36
inherit perl-module

DESCRIPTION="A family of perl modules to streamline writing Nagios plugins"

SLOT="0"
KEYWORDS="amd64 hppa x86"
IUSE=""

DEPEND="dev-perl/Class-Accessor
	dev-perl/Config-Tiny
	dev-perl/Params-Validate
	dev-perl/Math-Calc-Units"
RDEPEND="${DEPEND}"

SRC_TEST="do"
