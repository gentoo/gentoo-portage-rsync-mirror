# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Services_W3C_HTMLValidator/PEAR-Services_W3C_HTMLValidator-1.0.0-r1.ebuild,v 1.1 2012/01/18 22:06:16 mabi Exp $

EAPI="4"

inherit php-pear-r1

DESCRIPTION="Object oriented interface to the API of validator.w3.org."

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-php/PEAR-HTTP_Request2-0.2.0"
