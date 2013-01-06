# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-MvcMailTiein/ezc-MvcMailTiein-1.0.1.ebuild,v 1.1 2011/12/14 22:15:42 mabi Exp $

EZC_BASE_MIN="1.8"
inherit php-ezc

DESCRIPTION="This eZ component provides a request parser that extracts request data from e-mail"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php/ezc-MvcTools-1.0
	>=dev-php/ezc-Mail-1.7"
