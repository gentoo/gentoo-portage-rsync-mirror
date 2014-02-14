# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/oto/oto-0.5.ebuild,v 1.4 2014/02/14 19:07:30 maekke Exp $

DESCRIPTION="Open Type Organizer"
HOMEPAGE="http://sourceforge.net/projects/oto/"
SRC_URI="mirror://sourceforge/oto/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~ia64 ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS=( AUTHORS ChangeLog INSTALL NEWS README )

src_install() {
	emake DESTDIR="${D}" install || die
}
