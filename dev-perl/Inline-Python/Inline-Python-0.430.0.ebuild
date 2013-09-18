# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Inline-Python/Inline-Python-0.430.0.ebuild,v 1.1 2013/09/18 03:48:34 patrick Exp $

EAPI=2

MODULE_AUTHOR=NINE
MODULE_VERSION=0.43
inherit perl-module

DESCRIPTION="Easy implementation of Python extensions"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/Inline-0.42
	dev-lang/python"
RDEPEND="${DEPEND}"

SRC_TEST="do"
