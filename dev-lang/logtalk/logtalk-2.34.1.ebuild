# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/logtalk/logtalk-2.34.1.ebuild,v 1.4 2014/08/10 20:29:05 slyfox Exp $

inherit eutils versionator

DESCRIPTION="Open source object-oriented logic programming language"
HOMEPAGE="http://logtalk.org"
MY_PV="lgt$(delete_all_version_separators)"
SRC_URI="http://logtalk.org/files/${MY_PV}.tar.bz2"
LICENSE="Artistic-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnupl qupl swipl xsbpl yappl"

DEPEND=""
RDEPEND="
	gnupl? ( dev-lang/gprolog )
	qupl? ( !amd64? ( dev-lang/qu-prolog ) )
	swipl? ( dev-lang/swi-prolog )
	xsbpl? ( x86? ( dev-lang/xsb ) )
	yappl? ( dev-lang/yap )
	${DEPEND}"

S="${WORKDIR}/${MY_PV}"

src_install() {
	# Change default user dir to ~/.logtalk
	sed -i -e 's;$HOME/logtalk;$HOME/.logtalk;' \
		integration/*.sh \
		|| die "Cannot sed integration scripts."

	# Look at scripts/install.sh
	# for upstream installation process.
	mv scripts/cplgtdirs.sh integration/
	mkdir -p "${D}/usr/share/${P}"
	cp -r compiler configs contributions VERSION.txt \
		integration library wenv xml libpaths \
		examples "${D}/usr/share/${P}" \
		|| die "Failed to copy files"

	dodoc BIBLIOGRAPHY.bib CUSTOMIZE.txt INSTALL.txt \
		LICENSE.txt QUICK_START.txt README.txt \
		VERSION.txt RELEASE_NOTES.txt UPGRADING.txt
	dohtml -r manuals/*

	dosym /usr/share/${P}/integration/cplgtdirs.sh /usr/bin/cplgtdirs
	use gnupl && dosym /usr/share/${P}/integration/gplgt.sh /usr/bin/gplgt
	use qupl && ! use amd64 && dosym /usr/share/${P}/integration/qplgt.sh /usr/bin/qplgt
	use swipl && dosym /usr/share/${P}/integration/swilgt.sh /usr/bin/swilgt
	use xsbpl && use x86 && dosym /usr/share/${P}/integration/xsblgt.sh /usr/bin/xsblgt
	use yappl && dosym /usr/share/${P}/integration/yaplgt.sh /usr/bin/yaplgt

	echo "LOGTALKHOME=/usr/share/${P}" > 99logtalk
	doenvd 99logtalk
}

pkg_postinst() {
	ewarn "To start logtalk, use one of the following:"
	use gnupl && ewarn "GNU Prolog: /usr/bin/gplgt"
	use qupl && ! use amd64 && ewarn "Qu Prolog: /usr/bin/qplgt"
	use swipl && ewarn "SWI Prolog: /usr/bin/swilgt"
	use xsbpl && use x86 && ewarn "XSB: /usr/bin/xsblgt"
	use yappl && ewarn "YAP: /usr/bin/yaplgt"
	ewarn ""

	ewarn "The environment has been set up to make the above"
	ewarn "integration scripts find files automatically for logtalk."
	ewarn "Please run 'etc-update && source /etc/profile' to update"
	ewarn "the environment now, otherwise it will be updated at next"
	ewarn "login."
}
