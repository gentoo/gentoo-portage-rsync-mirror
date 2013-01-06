# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTTP_Download/PEAR-HTTP_Download-1.1.3-r1.ebuild,v 1.5 2010/10/20 14:17:27 hwoarang Exp $

EAPI="2"

inherit php-pear-r1

DESCRIPTION="Provides functionality to send HTTP downloads."
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="minimal postgres"
DEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )
	dev-lang/php[postgres=]"
RDEPEND="${DEPEND}
	dev-php/PEAR-HTTP_Header
	!minimal? ( dev-php/PEAR-MIME_Type )"
