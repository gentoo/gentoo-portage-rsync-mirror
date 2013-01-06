# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Clean/HTML-Clean-0.800.0.ebuild,v 1.2 2011/09/03 21:04:54 tove Exp $

EAPI=4

MODULE_AUTHOR=LINDNER
MODULE_VERSION=0.8
inherit perl-module

DESCRIPTION="Cleans up HTML code for web browsers, not humans"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND="!<app-text/html-xml-utils-5.3"
