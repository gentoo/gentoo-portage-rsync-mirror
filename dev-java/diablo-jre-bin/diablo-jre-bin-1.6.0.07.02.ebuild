# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/diablo-jre-bin/diablo-jre-bin-1.6.0.07.02.ebuild,v 1.3 2011/05/21 04:36:19 ssuominen Exp $

inherit java-vm-2 eutils versionator

DESCRIPTION="Java Runtime Environment"
HOMEPAGE="http://www.FreeBSDFoundation.org/downloads/java.shtml"
MY_PV=$(replace_version_separator 3 '_')
MY_PVA=$(replace_version_separator 4 '-b' ${MY_PV})

SRC_URI="diablo-latte-freebsd7-i386-${MY_PVA}.tar.bz2"

LICENSE="sun-bcla-java-vm"
SLOT="1.6"
KEYWORDS="-* ~x86-fbsd"
RESTRICT="fetch"
IUSE="X nsplugin"

QA_TEXTRELS_x86="opt/${P}/jre/lib/i386/motif21/libmawt.so opt/${P}/jre/lib/i386/server/libjvm.so opt/${P}/jre/lib/i386/client/libjvm.so"

JAVA_VM_NO_GENERATION1=true

DEPEND=""
RDEPEND="X? (
			x11-libs/libX11
			x11-libs/libXext
			x11-libs/libXi
			x11-libs/libXp
			x11-libs/libXt
			x11-libs/libXtst
		)
		>=sys-freebsd/freebsd-lib-7"

S="${WORKDIR}/diablo-jre$(get_version_component_range 1-4 ${MY_PV})"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from:"
	einfo "${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

src_install() {
	local dirs="bin lib man plugin javaws"

	dodir /opt/${P}

	for i in $dirs ; do
		cp -pPR $i "${D}"/opt/${P}/ || die "failed to build"
	done

	dodoc COPYRIGHT README
	dohtml Welcome.html

	if use nsplugin; then
		install_mozilla_plugin /opt/${P}/plugin/i386/ns7/libjavaplugin_oji.so
	fi

	# Change libz.so.4 to libz.so.1
	scanelf -qR -N libz.so.4 -F "#N" "${D}"/opt/${P}/ | \
		while read i; do
		if [[ $(strings "$i" | fgrep -c libz.so.4) -ne 1 ]]; then
			export SANITY_CHECK_LIBZ_FAILED=1
			break
		fi
		sed -i -e 's/libz\.so\.4/libz.so.1/g' "$i"
	done
	[[ "$SANITY_CHECK_LIBZ_FAILED" = "1" ]] && die "failed to change libz.so.4 to libz.so.1"

	# create dir for system preferences
	dodir /opt/${P}/.systemPrefs

	# install control panel for Gnome/KDE
	sed -e "s/INSTALL_DIR\/JRE_NAME_VERSION/\/opt\/${P}/" \
		-e "s/\(Name=Java\)/\1 Control Panel/" \
		"${D}"/opt/${P}/plugin/desktop/sun_java.desktop > \
		"${T}"/sun_java-jre.desktop

	domenu "${T}"/sun_java-jre.desktop

	set_java_env
}

pkg_postinst() {
	# Create files used as storage for system preferences.
	PREFS_LOCATION=/opt/${P}/
	mkdir -p "${PREFS_LOCATION}"/.systemPrefs
	if [ ! -f "${PREFS_LOCATION}"/.systemPrefs/.system.lock ] ; then
		touch "${PREFS_LOCATION}"/.systemPrefs/.system.lock
		chmod 644 "${PREFS_LOCATION}"/.systemPrefs/.system.lock
	fi
	if [ ! -f "${PREFS_LOCATION}"/.systemPrefs/.systemRootModFile ] ; then
		touch "${PREFS_LOCATION}"/.systemPrefs/.systemRootModFile
		chmod 644 "${PREFS_LOCATION}"/.systemPrefs/.systemRootModFile
	fi

	# Set as default VM if none exists
	java-vm-2_pkg_postinst

	if ! use X; then
		local xwarn="X11 libraries and/or"
	fi

	echo
	ewarn "Some parts of Sun's JRE require ${xwarn} net-print/cups or net-print/lprng to be installed."
	ewarn "Be careful which Java libraries you attempt to use."
}
