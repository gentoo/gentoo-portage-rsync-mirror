# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-TranslationCacheTiein/ezc-TranslationCacheTiein-1.1.2.ebuild,v 1.2 2012/01/29 16:22:42 mabi Exp $

EZC_BASE_MIN="1.2"
inherit php-ezc

DESCRIPTION="This eZ component adds the TranslationCache backend to the Translation component."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php/ezc-Translation-1.1.4
	>=dev-php/ezc-Cache-1.1.2"
