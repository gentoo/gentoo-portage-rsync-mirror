# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/porticron/porticron-0.5.2.ebuild,v 1.2 2010/07/17 07:19:10 hollow Exp $

DESCRIPTION="porticron is a cron script to sync portage and send update mails to root"
HOMEPAGE="http://bb.xnull.de/projects/porticron/"
SRC_URI="http://bb.xnull.de/projects/porticron/dist/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc x86"
IUSE=""

DEPEND=""
RDEPEND="net-dns/bind-tools"

src_install() {
	dosbin bin/porticron
	insinto /etc
	doins etc/porticron.conf
}
