# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knutclient/knutclient-1.0.5.ebuild,v 1.1 2013/01/29 11:46:24 kensington Exp $

EAPI=5
KDE_LINGUAS="cs de es fr it pl pt_BR ru uk"
KDE_HANDBOOK="optional"
MY_P="knc${PV//./}"

inherit kde4-base

DESCRIPTION="A visual KDE client for UPS systems"
HOMEPAGE="http://sites.google.com/a/prynych.cz/knutclient/"
SRC_URI="ftp://ftp.buzuluk.cz/pub/alo/knutclient/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

PATCHES=( "${FILESDIR}/${P}-desktop.patch" )
DOCS=( ChangeLog )

S=${WORKDIR}/${MY_P}
