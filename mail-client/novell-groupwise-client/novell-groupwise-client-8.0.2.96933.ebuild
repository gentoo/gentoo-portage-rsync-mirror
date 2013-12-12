# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/novell-groupwise-client/novell-groupwise-client-8.0.2.96933.ebuild,v 1.2 2013/12/12 07:35:23 jlec Exp $

RESTRICT="binchecks fetch mirror strip"

inherit eutils rpm multilib versionator

MY_PV=$(replace_version_separator 3 '-')
MY_P="${P/_p/-}"

DESCRIPTION="Novell Groupwise Client for Linux"
HOMEPAGE="http://www.novell.com/products/groupwise/"
SRC_URI="gw802_hp3_client_linux_multi.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="novell-jre multilib"
DEPEND=""
RDEPEND="sys-libs/libstdc++-v3
	!novell-jre? (
		|| ( virtual/jdk
		virtual/jre )
		multilib? (
		amd64? ( app-emulation/emul-linux-x86-java ) ) )
	multilib? (
		amd64? ( app-emulation/emul-linux-x86-compat ) )"

src_unpack() {
	unpack ${A}
	mkdir -p "${WORKDIR}"/${PN}-${MY_PV}
	cd ${PN}-${MY_PV}
	rpm_unpack ./../gw${MY_PV}_client_linux_multi/${PN}-${MY_PV}.i586.rpm
}

src_compile() { :; }

src_install() {
	JRE_DIR="${WORKDIR}"/${PN}-${MY_PV}/opt/novell/groupwise/client/java;

	if use novell-jre; then
		# Undo Sun's funny-business with packed .jar's
		for i in $JRE_DIR/lib/*.pack; do
			i_b=`echo $i | sed 's/\.pack$//'`;
			einfo "Unpacking `basename $i` -> `basename $i_b.jar`";
			$JRE_DIR/bin/unpack200 $i $i_b.jar || die "Unpack failed";
		done;
	else
		if use multilib; then
			rm -rf "${WORKDIR}"/${PN}-${MY_PV}/opt/novell/groupwise/client/java
			sed -i 's%/opt/novell/groupwise/client/java/lib/i386%`java-config --select-vm=emul-linux-x86-java --jre-home`/lib/i386/client:`java-config --select-vm=emul-linux-x86-java --jre-home`/lib/i386/server:`java-config --select-vm=emul-linux-x86-java --jre-home`/lib/i386%' "${WORKDIR}"/${PN}-${MY_PV}/opt/novell/groupwise/client/bin/groupwise
		else
			rm -rf "${WORKDIR}"/${PN}-${MY_PV}/opt/novell/groupwise/client/java
			sed -i 's%/opt/novell/groupwise/client/java/lib/i386%`java-config --jre-home`/jre/lib/i386/client:`java-config --jre-home`/jre/lib/i386/server:`java-config --jre-home`/jre/lib/i386%' "${WORKDIR}"/${PN}-${MY_PV}/opt/novell/groupwise/client/bin/groupwise
		fi
	fi

	domenu "${WORKDIR}"/${PN}-${MY_PV}/opt/novell/groupwise/client/gwclient.desktop

	mv "${WORKDIR}"/${PN}-${MY_PV}/opt "${D}"/ || die "mv opt"

	dodir /opt/bin
	dosym /opt/novell/groupwise/client/bin/groupwise /opt/bin/groupwise
}

pkg_nofetch() {
	einfo "You can obtain an evaluation version of the Groupwise client at"
	einfo "${HOMEPAGE} - please download ${SRC_URI}"
	einfo "and place it in ${DISTDIR}. Alternatively request the file"
	einfo "from the Groupwise server provider of your organization."
	einfo "Note that the client is useless without a server account."
}
