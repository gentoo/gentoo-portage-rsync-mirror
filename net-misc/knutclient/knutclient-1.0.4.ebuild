# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knutclient/knutclient-1.0.4.ebuild,v 1.1 2011/04/21 08:47:18 scarabeus Exp $

EAPI=4
KDE_LINGUAS="cs de es fr it pl pt_BR ru uk"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A visual KDE client for UPS systems"
HOMEPAGE="http://sites.google.com/a/prynych.cz/knutclient/"
SRC_URI="ftp://ftp.buzuluk.cz/pub/alo/knutclient/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DOCS=( AUTHORS ChangeLog README )
