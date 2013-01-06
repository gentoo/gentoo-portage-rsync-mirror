# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk-bin/ibm-jdk-bin-1.5.0.12_p4.ebuild,v 1.4 2011/03/26 14:08:04 ranger Exp $

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

JDK_DIST_PREFIX="ibm-java2-sdk-${TGZ_PV}-linux"
JAVACOMM_DIST_PREFIX="ibm-java2-javacomm-${TGZ_PV}-linux"

X86_JDK_DIST="${JDK_DIST_PREFIX}-i386.tgz"
X86_JAVACOMM_DIST="${JAVACOMM_DIST_PREFIX}-i386.tgz"

AMD64_JDK_DIST="${JDK_DIST_PREFIX}-x86_64.tgz"
AMD64_JAVACOMM_DIST="${JAVACOMM_DIST_PREFIX}-x86_64.tgz"

PPC_JDK_DIST="${JDK_DIST_PREFIX}-ppc.tgz"
PPC_JAVACOMM_DIST="${JAVACOMM_DIST_PREFIX}-ppc.tgz"

PPC64_JDK_DIST="${JDK_DIST_PREFIX}-ppc64.tgz"
PPC64_JAVACOMM_DIST="${JAVACOMM_DIST_PREFIX}-ppc64.tgz"

if use x86; then
	JDK_DIST=${X86_JDK_DIST}
	JAVACOMM_DIST=${X86_JAVACOMM_DIST}
	S="${WORKDIR}/ibm-java2-i386-50"
	LINK_ARCH="intel"
elif use amd64; then
	JDK_DIST=${AMD64_JDK_DIST}
	JAVACOMM_DIST=${AMD64_JAVACOMM_DIST}
	S="${WORKDIR}/ibm-java2-x86_64-50"
	LINK_ARCH="amd64"
elif use ppc; then
	JDK_DIST=${PPC_JDK_DIST}
	JAVACOMM_DIST=${PPC_JAVACOMM_DIST}
	S="${WORKDIR}/ibm-java2-ppc-50"
	LINK_ARCH="ipseries32"
elif use ppc64; then
	JDK_DIST=${PPC64_JDK_DIST}
	JAVACOMM_DIST=${PPC64_JAVACOMM_DIST}
	S="${WORKDIR}/ibm-java2-ppc64-50"
	LINK_ARCH="ipseries64"
fi

DIRECT_DOWNLOAD="https://www14.software.ibm.com/webapp/iwm/web/preLogin.do?source=sdk5&S_PKG=${LINK_ARCH}5sr${SERVICE_RELEASE_LINK}${FP_LINK}&S_TACT=105AGX05&S_CMP=JDK"

SLOT="1.5"
DESCRIPTION="IBM Java SE Development Kit"
HOMEPAGE="http://www.ibm.com/developerworks/java/jdk/"
DOWNLOADPAGE="${HOMEPAGE}linux/download.html"
# bug #125178
ALT_DOWNLOADPAGE="${HOMEPAGE}linux/older_download.html"

SRC_URI="x86? ( ${X86_JDK_DIST} )
	amd64? ( ${AMD64_JDK_DIST} )
	ppc? ( ${PPC_JDK_DIST} )
	ppc64? ( ${PPC64_JDK_DIST} )
	javacomm? (
		x86? ( ${X86_JAVACOMM_DIST} )
		amd64? ( ${AMD64_JAVACOMM_DIST} )
		ppc? ( ${PPC_JAVACOMM_DIST} )
		ppc64? ( ${PPC64_JAVACOMM_DIST} )
		)"
LICENSE="IBM-J1.5"
KEYWORDS="-* amd64 ppc ppc64 x86"
RESTRICT="fetch"
IUSE="X alsa doc examples javacomm nsplugin odbc"

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
	doc? ( =dev-java/java-sdk-docs-1.5.0* )
	nsplugin? (
		x86? ( =x11-libs/gtk+-2* =x11-libs/gtk+-1* )
		ppc? ( =x11-libs/gtk+-1* )
	)
	odbc? ( dev-db/unixODBC )"

DEPEND=""

QA_EXECSTACK_amd64="opt/${P}/jre/bin/libjclscar_23.so
	opt/${P}/jre/bin/libj9vrb23.so
	opt/${P}/jre/bin/libj9vm23.so
	opt/${P}/jre/bin/libj9trc23.so
	opt/${P}/jre/bin/libj9thr23.so
	opt/${P}/jre/bin/libj9shr23.so
	opt/${P}/jre/bin/libj9prt23.so
	opt/${P}/jre/bin/libj9jvmti23.so
	opt/${P}/jre/bin/libj9jpi23.so
	opt/${P}/jre/bin/libj9jit23.so
	opt/${P}/jre/bin/libj9jextract.so
	opt/${P}/jre/bin/libj9hookable23.so
	opt/${P}/jre/bin/libj9gc23.so
	opt/${P}/jre/bin/libj9dyn23.so
	opt/${P}/jre/bin/libj9dmp23.so
	opt/${P}/jre/bin/libj9dbg23.so
	opt/${P}/jre/bin/libj9bcv23.so
	opt/${P}/jre/bin/libj9ute23.so
	opt/${P}/jre/bin/libiverel23.so
	opt/${P}/jre/bin/classic/libjvm.so
	opt/${P}/jre/bin/j9vm/libjvm.so"

QA_TEXTRELS_amd64="opt/${P}/jre/bin/libjclscar_23.so
	opt/${P}/jre/bin/libj9jit23.so"

QA_EXECSTACK_x86="opt/${P}/jre/bin/j9vm/libjvm.so
	opt/${P}/jre/bin/libj9jvmti23.so
	opt/${P}/jre/bin/libj9hookable23.so
	opt/${P}/jre/bin/libj9vm23.so
	opt/${P}/jre/bin/libj9dyn23.so
	opt/${P}/jre/bin/libjclscar_23.so
	opt/${P}/jre/bin/libj9jpi23.so
	opt/${P}/jre/bin/libj9thr23.so
	opt/${P}/jre/bin/libj9dmp23.so
	opt/${P}/jre/bin/libj9prt23.so
	opt/${P}/jre/bin/libj9jit23.so
	opt/${P}/jre/bin/libiverel23.so
	opt/${P}/jre/bin/libj9trc23.so
	opt/${P}/jre/bin/libj9dbg23.so
	opt/${P}/jre/bin/libj9jextract.so
	opt/${P}/jre/bin/libj9shr23.so
	opt/${P}/jre/bin/libj9gc23.so
	opt/${P}/jre/bin/libj9vrb23.so
	opt/${P}/jre/bin/libj9bcv23.so
	opt/${P}/jre/bin/libj9aotrt23.so
	opt/${P}/jre/bin/classic/libjvm.so"

QA_TEXTRELS_ppc="opt/${P}/jre/bin/classic/libjvm.so
	opt/${P}/jre/bin/j9vm/libjvm.so
	opt/${P}/jre/bin/libj9aotrt23.so
	opt/${P}/jre/bin/libj9dbg23.so
	opt/${P}/jre/bin/libj9gc23.so
	opt/${P}/jre/bin/libj9gcchk23.so
	opt/${P}/jre/bin/libj9jextract.so
	opt/${P}/jre/bin/libj9jit23.so
	opt/${P}/jre/bin/libj9jitd23.so
	opt/${P}/jre/bin/libj9jpi23.so
	opt/${P}/jre/bin/libj9jvmti23.so
	opt/${P}/jre/bin/libj9prt23.so
	opt/${P}/jre/bin/libj9thr23.so
	opt/${P}/jre/bin/libj9thr23.so
	opt/${P}/jre/bin/libj9ute23.so
	opt/${P}/jre/bin/libj9vm23.so
	opt/${P}/jre/bin/libj9vm23.so
	opt/${P}/jre/bin/libjaas.so
	opt/${P}/jre/bin/libjclscar_23.so
	opt/${P}/jre/bin/libjsig.so
"

QA_TEXTRELS_ppc64="opt/${P}/jre/bin/libj9jextract.so
	opt/${P}/jre/bin/libjsig.so
	opt/${P}/jre/bin/libj9jitd23.so
	opt/${P}/jre/bin/libj9ute23.so
	opt/${P}/jre/bin/classic/libjvm.so
	opt/${P}/jre/bin/libj9prt23.so
	opt/${P}/jre/bin/libjclscar_23.so
	opt/${P}/jre/bin/j9vm/libjvm.so
	opt/${P}/jre/bin/libj9gc23.so
	opt/${P}/jre/bin/libj9dbg23.so
	opt/${P}/jre/bin/libj9thr23.so
	opt/${P}/jre/bin/libj9jpi23.so
	opt/${P}/jre/bin/libj9gcchk23.so
	opt/${P}/jre/bin/libj9vm23.so
	opt/${P}/jre/bin/libj9jit23.so"

QA_TEXTRELS_x86="opt/${P}/jre/bin/lib*.so
	opt/${P}/jre/bin/j9vm/libjvm.so
	opt/${P}/jre/bin/xawt/libmawt.so
	opt/${P}/jre/bin/javaplugin.so
	opt/${P}/jre/bin/motif21/libmawt.so
	opt/${P}/jre/bin/headless/libmawt.so
	opt/${P}/jre/bin/classic/libjvm.so
	opt/${P}/jre/lib/i386/libdeploy.so"

pkg_nofetch() {
	einfo "Due to license restrictions, we cannot redistribute or fetch the distfiles"
	einfo "Please visit: ${DOWNLOADPAGE}"

	einfo "Under J2SE 5.0, download SR${SERVICE_RELEASE}${FP_WEB} for your arch:"
	einfo "(note that we switched to tgz format because it's now versioned)"
	einfo "${JDK_DIST}"
	if use javacomm ; then
		einfo "${JAVACOMM_DIST}"
	fi

	einfo "You can use direct link to your arch download page:"
	einfo "${DIRECT_DOWNLOAD}"
	einfo "Place the file(s) in: ${DISTDIR}"
	einfo "Then restart emerge: 'emerge --resume'"

	einfo "Note: if SR${SERVICE_RELEASE}${FP_WEB} is not available at ${DOWNLOADPAGE}"
	einfo "it may have been moved to ${ALT_DOWNLOADPAGE}. Lately that page"
	einfo "isn't updated, but the files should still available through the"
	einfo "direct link to arch download page. If it doesn't work, file a bug."
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# bug #126105
	epatch "${FILESDIR}/${PN}-jawt.h.patch"
}

src_compile() { :; }

src_install() {
	# Copy all the files to the designated directory
	dodir /opt/${P}
	cp -pR "${S}"/{bin,jre,lib,include,src.jar} "${D}/opt/${P}/"

	dodir /opt/${P}/share
	if use examples; then
		cp -pPR "${S}/demo" "${D}/opt/${P}/share/"
	fi

	local x86plugin=libjavaplugin_ojigtk2.so
	local ppcplugin=libjavaplugin_oji.so
	local jrebindest="${D}/opt/${P}/jre/bin/"

	local plugin
	if use x86; then
		plugin=${x86plugin}
	elif use ppc; then
		plugin=${ppcplugin}
	fi

	plugin=/opt/${P}/jre/bin/${plugin}

	if use x86 || use ppc; then
		if use nsplugin; then
			install_mozilla_plugin ${plugin}
		fi
	fi

	dohtml -a html,htm,HTML -r docs
	dodoc "${S}/COPYRIGHT"

	set_java_env
	java-vm_revdep-mask
}
