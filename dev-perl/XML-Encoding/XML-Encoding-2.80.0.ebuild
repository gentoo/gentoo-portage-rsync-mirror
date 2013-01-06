# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Encoding/XML-Encoding-2.80.0.ebuild,v 1.2 2011/09/03 21:04:51 tove Exp $

EAPI=4

MODULE_AUTHOR=SHAY
MODULE_VERSION=2.08
inherit perl-module

DESCRIPTION="Perl Module that parses encoding map XML files"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND="dev-perl/XML-Parser"
DEPEND="${RDEPEND}"

SRC_TEST=do
