# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TableContentParser/HTML-TableContentParser-0.130.0.ebuild,v 1.2 2011/09/03 21:04:28 tove Exp $

EAPI=4

MODULE_AUTHOR=SDRABBLE
MODULE_VERSION=0.13
inherit perl-module

DESCRIPTION="Parse the content of tables in HTML"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND="dev-perl/HTML-Parser"
DEPEND="${RDEPEND}"

SRC_TEST=do
PATCHES=( "${FILESDIR}"/0.13-test.patch )
