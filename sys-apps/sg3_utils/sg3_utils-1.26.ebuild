# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sg3_utils/sg3_utils-1.26.ebuild,v 1.6 2010/05/22 16:52:30 armin76 Exp $

inherit eutils

DESCRIPTION="Apps for querying the sg SCSI interface"
HOMEPAGE="http://sg.danny.cz/sg/"
SRC_URI="http://sg.danny.cz/sg/p/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""
DEPEND="sys-devel/libtool"
RDEPEND="sys-apps/sdparm
		 !>=sys-apps/sdparm-1.04"
PDEPEND=">=sys-apps/rescan-scsi-bus-1.24"

src_install() {
	dodoc ChangeLog AUTHORS COVERAGE CREDITS README*
	dodoc doc/README.doc examples/*.txt
	newdoc scripts/README README.scripts
	make install DESTDIR="${D}" || die "make install failed"
	dosbin scripts/{scsi,sas}*
}
