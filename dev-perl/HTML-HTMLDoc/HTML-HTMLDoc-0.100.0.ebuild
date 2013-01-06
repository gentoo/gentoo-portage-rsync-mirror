# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-HTMLDoc/HTML-HTMLDoc-0.100.0.ebuild,v 1.2 2011/09/03 21:04:25 tove Exp $

EAPI=4

MODULE_AUTHOR=MFRANKL
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="Perl interface to the htmldoc program for producing PDF-Files from HTML-Content"

SLOT="0"
KEYWORDS="amd64 ~arm ia64 ~ppc sparc x86"
IUSE=""

RDEPEND="app-text/htmldoc"
DEPEND="${RDEPEND}"

SRC_TEST="do"
