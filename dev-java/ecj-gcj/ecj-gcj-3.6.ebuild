# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ecj-gcj/ecj-gcj-3.6.ebuild,v 1.2 2012/09/16 13:12:54 chithanh Exp $

EAPI=4

inherit java-pkg-2 toolchain-funcs

MY_PN="ecj"
DMF="R-${PV}-201006080911"
S="${WORKDIR}"

DESCRIPTION="A subset of Eclipse Compiler for Java compiled by gcj, serving as javac in gcj-jdk"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/eclipse/downloads/drops/${DMF}/${MY_PN}src-${PV}.zip"

IUSE="+native userland_GNU"

LICENSE="EPL-1.0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~x86"
SLOT="3.6"

MY_PS="${MY_PN}-${SLOT}"

# for compatibility with java eclass functions
JAVA_PKG_WANT_SOURCE=1.4
JAVA_PKG_WANT_TARGET=1.4

CDEPEND="sys-devel/gcc[gcj]
	>=app-admin/eselect-ecj-0.6"
DEPEND="${CDEPEND}
	app-arch/unzip
	userland_GNU? ( sys-apps/findutils )
	!dev-java/eclipse-ecj:3.5[gcj]"
RDEPEND="${CDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# We don't need the ant adapter here
	rm -f org/eclipse/jdt/core/JDTCompilerAdapter.java || die
	rm -fr org/eclipse/jdt/internal/antadapter || die

	# upstream build.xml excludes this
	rm -f META-INF/eclipse.inf || die

	# these java6 specific classes cannot compile with ecj
	rm -fr org/eclipse/jdt/internal/compiler/{apt,tool}/ || die
}

src_compile() {
	local javac_opts javac java jar

	local gccbin=$(gcc-config -B)
	local gccver=$(gcc-fullversion)

	local gcj="${gccbin}/gcj"
	javac="${gcj} -C --encoding=ISO-8859-1"
	jar="${gccbin}/gjar"
	java="${gccbin}/gij"

	mkdir -p bootstrap || die
	cp -pPR org bootstrap || die
	cd "${S}/bootstrap" || die

	einfo "bootstrapping ${MY_PN} with ${javac} ..."
	${javac} ${javac_opts} $(find org/ -name '*.java') || die
	find org/ -name '*.class' -o -name '*.properties' -o -name '*.rsc' |\
		xargs ${jar} cf ${MY_PN}.jar

	cd "${S}" || die

	einfo "building ${MY_PN} with bootstrapped ${MY_PN} ..."
	${java} -classpath bootstrap/${MY_PN}.jar \
		org.eclipse.jdt.internal.compiler.batch.Main \
		${javac_opts} -nowarn org || die
	find org/ -name '*.class' -o -name '*.properties' -o -name '*.rsc' |\
		xargs ${jar} cf ${MY_PN}.jar

	if use native; then
		einfo "Building native ${MY_PS} library, patience needed ..."
		${gcj} ${CFLAGS} -findirect-dispatch -shared -fPIC -Wl,-Bsymbolic \
			-o ${MY_PS}.so ${MY_PN}.jar || die
	fi
}

src_install() {
	java-pkg_dojar ${MY_PN}.jar
	dobin "${FILESDIR}/${PN}-${SLOT}"
	use native && dolib.so ${MY_PS}.so
}

pkg_postinst() {
	if use native; then
		$(gcc-config -B)/gcj-dbtool -a $(gcj-dbtool -p) \
			/usr/share/${PN}-${SLOT}/lib/ecj.jar \
			/usr/$(get_libdir)/${MY_PN}-${SLOT}.so
	fi

	einfo "To select between slots of ECJ..."
	einfo " # eselect ecj"

	eselect ecj update ${PN}-${SLOT}
}

pkg_postrm() {
	eselect ecj update
}
