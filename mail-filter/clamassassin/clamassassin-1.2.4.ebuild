# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/clamassassin/clamassassin-1.2.4.ebuild,v 1.2 2008/08/15 19:52:37 maekke Exp $

DESCRIPTION="clamassassin is a simple script for virus scanning (through clamav) an e-mail message as a
filter (like spamassassin)"
HOMEPAGE="http://jameslick.com/clamassassin/"
SRC_URI="http://jameslick.com/clamassassin/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="subject-rewrite clamd"
DEPEND=">=app-antivirus/clamav-0.90
		sys-apps/debianutils
		sys-apps/which
		mail-filter/procmail"

src_compile() {
	# Try to get location of clamd's DatabaseDirectory
	local clamav_dbdir=`awk '$1 == "DatabaseDirectory" { print $2 }' \
		/etc/clamd.conf`
	# If not defined in clamd.conf, go with default
	if [ -z "$clamav_dbdir" ] ; then
		clamav_dbdir="/var/lib/clamav"
	fi
	# Add an entry to sandbox write prediction list, so sandbox doesn't complain
	addpredict ${clamav_dbdir}/

	econf \
		$(use_enable subject-rewrite) \
		$(use_enable clamd clamdscan) \
		|| die
	# Fix problems with Portage exporting TMP and breaking clamassassin. #61806
	sed -i -e "s:${TMP}:/tmp:" clamassassin
}

src_install() {
	dobin clamassassin
	dodoc CHANGELOG LICENSE README
}
