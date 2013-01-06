# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/oto/oto-0.5.ebuild,v 1.3 2010/04/17 11:39:25 dirtyepic Exp $

DESCRIPTION="Open Type Organizer"
HOMEPAGE="http://sourceforge.net/projects/oto/"
SRC_URI="mirror://sourceforge/oto/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS=( AUTHORS ChangeLog INSTALL NEWS README )

src_install() {
	emake DESTDIR="${D}" install || die
}
