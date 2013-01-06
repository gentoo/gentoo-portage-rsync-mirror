# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jre-bin/ibm-jre-bin-1.5.0.12_p4.ebuild,v 1.4 2011/03/26 14:12:43 ranger Exp $

inherit java-vm-2 versionator eutils

JDK_RELEASE=$(get_version_component_range 2-3)
SERVICE_RELEASE=$(get_version_component_range 4)
SERVICE_RELEASE_LINK="${SERVICE_RELEASE}"

# versions ending with _pX translate to .X in distfile and fpX in SRC_URI
if [[ $(get_version_component_count) == 5 ]]; then
	FP_VERSION="$(get_version_component_range 5)"
	FP_VERSION="${FP_VERSION#p}"
	FP_WEB="-FP${FP_VERSION}"
	FP_LINK="fp${FP_VERSION}"
	TGZ_PV="${JDK_RELEASE}-${SERVICE_RELEASE}.${FP_VERSION}"
else
	FP_WEB=""
	FP_LINK=""
	TGZ_PV="${JDK_RELEASE}-${SERVICE_RELEASE}.0"
fi

JRE_DIST_PREFIX="ibm-java2-jre-${TGZ_PV}-linux"

X86_JRE_DIST="${JRE_DIST_PREFIX}-i386.tgz"
AMD64_JRE_DIST="${JRE_DIST_PREFIX}-x86_64.tgz"
PPC_JRE_DIST="${JRE_DIST_PREFIX}-ppc.tgz"
PPC64_JRE_DIST="${JRE_DIST_PREFIX}-ppc64.tgz"

if use x86; then
	JRE_DIST=${X86_JRE_DIST}
	S="${WORKDIR}/ibm-java2-i386-50"
	LINK_ARCH="intel"
elif use amd64; then
	JRE_DIST=${AMD64_JRE_DIST}
	S="${WORKDIR}/ibm-java2-x86_64-50"
	LINK_ARCH="amd64"
elif use ppc; then
	JRE_DIST=${PPC_JRE_DIST}
	S="${WORKDIR}/ibm-java2-ppc-50"
	LINK_ARCH="ipseries32"
elif use ppc64; then
	JRE_DIST=${PPC64_JRE_DIST}
	S="${WORKDIR}/ibm-java2-ppc64-50"
	LINK_ARCH="ipseries64"
fi

DIRECT_DOWNLOAD="https://www14.software.ibm.com/webapp/iwm/web/preLogin.do?source=sdk5&S_PKG=${LINK_ARCH}5sr${SERVICE_RELEASE_LINK}${FP_LINK}&S_TACT=105AGX05&S_CMP=JDK"

SLOT="1.5"
DESCRIPTION="IBM Java SE Runtime Environment"
HOMEPAGE="http://www.ibm.com/developerworks/java/jdk/"
DOWNLOADPAGE="${HOMEPAGE}linux/download.html"
# bug #125178
ALT_DOWNLOADPAGE="${HOMEPAGE}linux/older_download.html"

SRC_URI="x86? ( ${X86_JRE_DIST} )
	amd64? ( ${AMD64_JRE_DIST} )
	ppc? ( ${PPC_JRE_DIST} )
	ppc64? ( ${PPC64_JRE_DIST} )"
LICENSE="IBM-J1.5"
KEYWORDS="-* amd64 ppc ppc64 x86"
RESTRICT="fetch"
IUSE="X alsa nsplugin odbc"

RDEPEND="=virtual/libstdc++-3.3
		X? (
			x11-libs/libXext
			x11-libs/libXft
			x11-libs/libXi
			x11-libs/libXmu
			x11-libs/libXp
			x11-libs/libXtst
			x11-libs/libXt
			x11-libs/libX11
		)
		alsa? ( media-libs/alsa-lib )
		nsplugin? (
			x86? ( =x11-libs/gtk+-2* =x11-libs/gtk+-1* )
			ppc? ( =x11-libs/gtk+-1* )
		)
		odbc? ( dev-db/unixODBC )"
DEPEND=""

QA_EXECSTACK_amd64="opt/${P}/bin/libjclscar_23.so
	opt/${P}/bin/libj9vrb23.so
	opt/${P}/bin/libj9vm23.so
	opt/${P}/bin/libj9trc23.so
	opt/${P}/bin/libj9thr23.so
	opt/${P}/bin/libj9shr23.so
	opt/${P}/bin/libj9prt23.so
	opt/${P}/bin/libj9jvmti23.so
	opt/${P}/bin/libj9jpi23.so
	opt/${P}/bin/libj9jit23.so
	opt/${P}/bin/libj9jextract.so
	opt/${P}/bin/libj9hookable23.so
	opt/${P}/bin/libj9gc23.so
	opt/${P}/bin/libj9dyn23.so
	opt/${P}/bin/libj9dmp23.so
	opt/${P}/bin/libj9dbg23.so
	opt/${P}/bin/libj9bcv23.so
	opt/${P}/bin/libj9ute23.so
	opt/${P}/bin/libiverel23.so
	opt/${P}/bin/classic/libjvm.so
	opt/${P}/bin/j9vm/libjvm.so"

QA_TEXTRELS_amd64="opt/${P}/bin/libjclscar_23.so
	opt/${P}/bin/libj9jit23.so"

QA_EXECSTACK_x86="opt/${P}/bin/j9vm/libjvm.so
	opt/${P}/bin/libj9jvmti23.so
	opt/${P}/bin/libj9hookable23.so
	opt/${P}/bin/libj9vm23.so
	opt/${P}/bin/libj9dyn23.so
	opt/${P}/bin/libjclscar_23.so
	opt/${P}/bin/libj9jpi23.so
	opt/${P}/bin/libj9thr23.so
	opt/${P}/bin/libj9dmp23.so
	opt/${P}/bin/libj9prt23.so
	opt/${P}/bin/libj9jit23.so
	opt/${P}/bin/libiverel23.so
	opt/${P}/bin/libj9trc23.so
	opt/${P}/bin/libj9dbg23.so
	opt/${P}/bin/libj9jextract.so
	opt/${P}/bin/libj9shr23.so
	opt/${P}/bin/libj9gc23.so
	opt/${P}/bin/libj9vrb23.so
	opt/${P}/bin/libj9bcv23.so
	opt/${P}/bin/libj9aotrt23.so
	opt/${P}/bin/classic/libjvm.so"

QA_TEXTRELS_ppc="opt/${P}/bin/classic/libjvm.so
	opt/${P}/bin/j9vm/libjvm.so
	opt/${P}/bin/libj9aotrt23.so
	opt/${P}/bin/libj9dbg23.so
	opt/${P}/bin/libj9gc23.so
	opt/${P}/bin/libj9gcchk23.so
	opt/${P}/bin/libj9jextract.so
	opt/${P}/bin/libj9jit23.so
	opt/${P}/bin/libj9jitd23.so
	opt/${P}/bin/libj9jpi23.so
	opt/${P}/bin/libj9jvmti23.so
	opt/${P}/bin/libj9prt23.so
	opt/${P}/bin/libj9thr23.so
	opt/${P}/bin/libj9thr23.so
	opt/${P}/bin/libj9ute23.so
	opt/${P}/bin/libj9vm23.so
	opt/${P}/bin/libj9vm23.so
	opt/${P}/bin/libjaas.so
	opt/${P}/bin/libjclscar_23.so
	opt/${P}/bin/libjsig.so
"

QA_TEXTRELS_ppc64="opt/${P}/bin/libj9jextract.so
	opt/${P}/bin/libjsig.so
	opt/${P}/bin/libj9jitd23.so
	opt/${P}/bin/libj9ute23.so
	opt/${P}/bin/classic/libjvm.so
	opt/${P}/bin/libj9prt23.so
	opt/${P}/bin/libjclscar_23.so
	opt/${P}/bin/j9vm/libjvm.so
	opt/${P}/bin/libj9gc23.so
	opt/${P}/bin/libj9dbg23.so
	opt/${P}/bin/libj9thr23.so
	opt/${P}/bin/libj9jpi23.so
	opt/${P}/bin/libj9gcchk23.so
	opt/${P}/bin/libj9vm23.so
	opt/${P}/bin/libj9jit23.so"

QA_TEXTRELS_x86="opt/${P}/bin/lib*.so
	opt/${P}/bin/j9vm/libjvm.so
	opt/${P}/bin/xawt/libmawt.so
	opt/${P}/bin/javaplugin.so
	opt/${P}/bin/motif21/libmawt.so
	opt/${P}/bin/headless/libmawt.so
	opt/${P}/bin/classic/libjvm.so
	opt/${P}/lib/i386/libdeploy.so"

pkg_nofetch() {
	einfo "Due to license restrictions, we cannot redistribute or fetch the distfiles"
	einfo "Please visit: ${DOWNLOADPAGE}"

	einfo "Under J2SE 5.0, download SR${SERVICE_RELEASE}${FP_WEB} for your arch:"
	einfo "${JRE_DIST}"

	einfo "You can use direct link to your arch download page:"
	einfo "${DIRECT_DOWNLOAD}"
	einfo "Place the file(s) in: ${DISTDIR}"
	einfo "Then restart emerge: 'emerge --resume'"

	einfo "Note: if SR${SERVICE_RELEASE}${FP_WEB} is not available at ${DOWNLOADPAGE}"
	einfo "it may have been moved to ${ALT_DOWNLOADPAGE}. Lately that page"
	einfo "isn't updated, but the files should still available through the"
	einfo "direct link to arch download page. If it doesn't work, file a bug."
}

src_compile() { :; }

src_install() {
	# Copy all the files to the designated directory
	dodir /opt/${P}
	cp -pR "${S}"/jre/* "${D}/opt/${P}/"

	local x86plugin=libjavaplugin_ojigtk2.so
	local ppcplugin=libjavaplugin_oji.so
	local jrebindest="${D}/opt/${P}/bin/"

	local plugin
	if use x86; then
		plugin=${x86plugin}
	elif use ppc; then
		plugin=${ppcplugin}
	fi

	plugin=/opt/${P}/bin/${plugin}

	if use x86 || use ppc; then
		if use nsplugin; then
			install_mozilla_plugin ${plugin}
		fi
	fi

	dohtml -a html,htm,HTML -r docs || die
	dodoc "${S}/COPYRIGHT" || die

	set_java_env
	java-vm_revdep-mask
}
