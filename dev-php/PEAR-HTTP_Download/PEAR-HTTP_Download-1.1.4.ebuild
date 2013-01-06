# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTTP_Download/PEAR-HTTP_Download-1.1.4.ebuild,v 1.4 2012/06/19 13:09:20 ago Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="Provides functionality to send HTTP downloads."
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="minimal postgres"
RDEPEND="${DEPEND}
	dev-lang/php[postgres?]
	dev-php/PEAR-HTTP_Header
	!minimal? (
		dev-php/PEAR-MIME_Type
		dev-php/PEAR-Archive_Tar
	)"
