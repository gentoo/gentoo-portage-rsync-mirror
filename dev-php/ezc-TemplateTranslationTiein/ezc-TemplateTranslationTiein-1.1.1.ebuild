# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-TemplateTranslationTiein/ezc-TemplateTranslationTiein-1.1.1.ebuild,v 1.1 2011/12/14 22:21:45 mabi Exp $

EZC_BASE_MIN="1.8"
inherit php-ezc

DESCRIPTION="This eZ component provides functionality to use translations inside templates"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php/ezc-Template-1.4
	>=dev-php/ezc-Translation-1.3
	>=dev-php/ezc-ConsoleTools-1.5"
