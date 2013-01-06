# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Mail_Mime/PEAR-Mail_Mime-1.8.3.ebuild,v 1.2 2012/03/13 13:17:27 kumba Exp $

EAPI="4"

inherit php-pear-r1 eutils

DESCRIPTION="Provides classes to deal with creation and manipulation of mime messages"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

PDEPEND="dev-php/PEAR-Mail_mimeDecode"

src_prepare() {
	# see Bug 125451; http://pear.php.net/bugs/bug.php?id=5333
	epatch "${FILESDIR}"/${PV}-php-pass-by-reference-fix.patch
}
