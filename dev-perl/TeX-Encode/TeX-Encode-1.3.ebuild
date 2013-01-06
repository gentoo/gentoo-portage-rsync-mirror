# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TeX-Encode/TeX-Encode-1.3.ebuild,v 1.1 2012/02/19 14:33:19 dilfridge Exp $

EAPI=4

MODULE_AUTHOR="TIMBRODY"

inherit perl-module

DESCRIPTION="Encode/decode Perl utf-8 strings into TeX"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/HTML-Parser-3.670.0
	dev-lang/perl"
