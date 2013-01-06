# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/freemind/freemind-0.9.0_rc6.ebuild,v 1.2 2010/02/28 11:40:44 caster Exp $

EAPI="2"

# will handle rewriting myself
JAVA_PKG_BSFIX="off"
WANT_ANT_TASKS="ant-nodeps ant-trax"
inherit java-pkg-2 java-ant-2 eutils

MY_PV=${PV//beta/Beta_}
MY_PV=${MY_PV//rc/RC_}

DESCRIPTION="Mind-mapping software written in Java"
HOMEPAGE="http://freemind.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc groovy latex pdf svg"
COMMON_DEP="dev-java/jgoodies-forms:0
	dev-java/jibx:0
	>=dev-java/simplyhtml-0.13.1:0
	dev-java/commons-lang:2.1
	dev-java/javahelp:0
	groovy? ( dev-java/groovy )
	latex? ( dev-java/hoteqn:0 )
	pdf? ( dev-java/batik:1.7
		>=dev-java/fop-0.95:0 )
	svg? ( dev-java/batik:1.7
		>=dev-java/fop-0.95:0 )"
DEPEND=">=virtual/jdk-1.4
	dev-java/xsd2jibx:0
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

S="${WORKDIR}/${PN}"

java_prepare() {
	# kill the jarbundler taskdef
	epatch "${FILESDIR}/${PN}-0.9.0_rc1-build.xml.patch"

	use groovy || rm plugins/build_scripting.xml || die
	use latex || rm plugins/build_latex.xml || die
	if ! use pdf && ! use svg ; then
		rm plugins/build_svg.xml || die
	fi

	local xml
	for xml in $(find . -name 'build*.xml'); do
		java-ant_rewrite-classpath ${xml}
		java-ant_bsfix_one ${xml}
	done

	rm -v lib/*.jar lib/*.zip lib/*/*.jar \
		plugins/*/*.jar plugins/*/*/*.jar || die
}

src_compile() {
	local jibxlibs="$(java-pkg_getjars --build-only --with-dependencies xsd2jibx)"
	local gcp="jgoodies-forms,jibx,commons-lang-2.1,javahelp,simplyhtml"
	use groovy && gcp="${gcp},groovy"
	use latex && gcp="${gcp},hoteqn"
	if use pdf || use svg ; then
		# there is both direct batik usage and through fop
		gcp="${gcp},batik-1.7,fop"
	fi
	local gcp="$(java-pkg_getjars --with-dependencies ${gcp}):lib/bindings.jar"
	ANT_TASKS="${WANT_ANT_TASKS} jibx xsd2jibx" eant -Djibxlibs="${jibxlibs}" \
		-Dgentoo.classpath="${gcp}" -Dbasedir="${PWD}" dist browser $(use_doc doc)
}

src_install() {
	cd "${WORKDIR}/bin/dist"
	local dest="/usr/share/${PN}/"

	java-pkg_dojar lib/*.jar

	insinto "${dest}"
	doins -r accessories browser/ doc/ plugins/ patterns.xml || die

	use doc && java-pkg_dojavadoc doc/javadoc

	java-pkg_dolauncher ${PN} --java_args "-Dfreemind.base.dir=${dest}" \
		--pwd "${dest}" --main freemind.main.FreeMindStarter

	newicon "${S}/images/FreeMindWindowIcon.png" freemind.png

	make_desktop_entry freemind Freemind freemind Utility
}
