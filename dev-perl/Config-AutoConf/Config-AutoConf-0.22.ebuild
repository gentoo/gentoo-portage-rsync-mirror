# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-AutoConf/Config-AutoConf-0.22.ebuild,v 1.2 2013/08/03 20:19:03 mrueg Exp $

EAPI=5

MODULE_AUTHOR="AMBS"
MODULE_SECTION="Config"

inherit perl-module

DESCRIPTION="A module to implement some of AutoConf macros in pure perl"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="test? (	>=dev-perl/Test-Pod-1.14
	>=dev-perl/Test-Pod-Coverage-1.08 )"
RDEPEND="dev-perl/Capture-Tiny"

SRC_TEST="do"
