# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-MvcTemplateTiein/ezc-MvcTemplateTiein-1.0.ebuild,v 1.1 2011/12/14 22:16:17 mabi Exp $

EZC_BASE_MIN="1.8"
inherit php-ezc

DESCRIPTION="This eZ component provides a view handler that renders result data with the Template component"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php/ezc-MvcTools-1.0
	>=dev-php/ezc-Template-1.3.1"
