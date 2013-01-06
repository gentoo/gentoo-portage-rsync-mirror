# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sdparm/sdparm-1.06.ebuild,v 1.7 2012/02/02 15:43:16 ssuominen Exp $

DESCRIPTION="Utility to output and modify parameters on a SCSI device, like hdparm"
HOMEPAGE="http://sg.danny.cz/sg/sdparm.html"
SRC_URI="http://sg.danny.cz/sg/p/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-linux"
IUSE=""

# Older releases contain a conflicting sas_disk_blink
RDEPEND="!<sys-apps/sg3_utils-1.28"

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc NEWS AUTHORS ChangeLog CREDITS README notes.txt
	dosbin scripts/sas* || die

	# These don't exist yet.  Someone wanna copy hdparm's and make them work? :)
#	newinitd ${FILESDIR}/sdparm-init-7 sdparm
#	newconfd ${FILESDIR}/sdparm-conf.d.3 sdparm
}
