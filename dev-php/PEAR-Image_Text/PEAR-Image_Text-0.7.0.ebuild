# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Image_Text/PEAR-Image_Text-0.7.0.ebuild,v 1.3 2014/03/03 23:44:54 pacho Exp $

EAPI=5

inherit php-pear-r1

DESCRIPTION="Advanced text manipulations in images."
LICENSE="PHP-3"
SLOT="0"

KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-lang/php[gd]"
