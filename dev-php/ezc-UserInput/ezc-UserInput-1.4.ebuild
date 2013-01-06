# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-UserInput/ezc-UserInput-1.4.ebuild,v 1.2 2012/01/29 16:25:32 mabi Exp $

EAPI=4

EZC_BASE_MIN="1.8"
inherit php-ezc

DESCRIPTION="This eZ component assists you to safely import user input variables into your application."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/php[filter]"
