# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krunner-kopete-contacts/krunner-kopete-contacts-0.4.ebuild,v 1.3 2014/03/21 18:16:44 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="A krunner plug-in that allows you to open conversation with your contact"
HOMEPAGE="http://www.kde-apps.org/content/show.php?action=content&content=105263"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/105263-${P}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep kopete)
"
RDEPEND="${DEPEND}"

DOCS=(README)
