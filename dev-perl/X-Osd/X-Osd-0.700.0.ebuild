# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/X-Osd/X-Osd-0.700.0.ebuild,v 1.1 2011/08/28 07:34:06 tove Exp $

EAPI=4

MODULE_AUTHOR=GOZER
MODULE_VERSION=0.7
inherit perl-module

DESCRIPTION="Perl glue to libxosd (X OnScreen Display)"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/xosd"
RDEPEND="${DEPEND}"
