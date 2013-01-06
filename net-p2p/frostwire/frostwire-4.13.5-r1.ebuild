# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/frostwire/frostwire-4.13.5-r1.ebuild,v 1.6 2012/05/21 19:35:57 ssuominen Exp $

EAPI=1
JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Frostwire Java Gnutella client"
HOMEPAGE="http://www.frostwire.com"
SRC_URI="http://www.frostwire.com/frostwire/${PV}/${P}.src.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="gtk"
IUSE=""

#	dev-java/commons-httpclient
#	dev-java/commons-pool
COMMON_DEP="
	dev-java/commons-logging
	dev-java/commons-net
	dev-java/icu4j:0
	dev-java/jgoodies-looks:1.2
	dev-java/jmdns
	dev-java/jython:0
	dev-java/log4j
	dev-java/xml-commons-external"

DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

RDEPEND=">=virtual/jre-1.5
	dev-java/asm
	${COMMON_DEP}"

S="${WORKDIR}/${P}.src"

PREFIX="/usr/share/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

#Todo
#	java-ant_rewrite-classpath

	find . '(' -name '*.bat' -o -name '*.exe' ')' -delete
#	find ${S} '(' -name '*.class' -o -name '*.jar' ')' -print -delete

# Tried to remove but seem to be required :(
#	rm -fR lib/jars/osx lib/jars/windows

	cd lib/jars
	rm -fR commons-logging.jar commons-net.jar \
		log4j.jar icu4j.jar jmdns.jar

# Seems to want a modified version of commons-httpclient
#	java-pkg_jar-from commons-httpclient
	java-pkg_jar-from commons-logging

# Seems to want a modified version of commons-pool
#	java-pkg_jar-from commons-pool
	java-pkg_jar-from commons-net
	java-pkg_jar-from log4j
	java-pkg_jar-from icu4j
	java-pkg_jar-from jmdns
	java-pkg_jar-from jgoodies-looks-1.2
	java-pkg_jar-from jython

# bye bye hashes, crude but effective :)
	cat /dev/null > "${S}/lib/jars/hashes"

}

src_compile() {
	cd "${S}/core"
	eant
	cd "${S}/gui"
	eant
	eant FrostWireJar

	# Make themes.jar
	cd "${S}/lib/themes"
	sh makeThemesJar.sh

	# temp fix/hack for bug #215423 till bug #180755 is resolved
	# bit noisy when not found, but better than command not found :)
	[ ! -p native2ascii > /dev/null ] && export PATH="${PATH}:$(java-config -O)/bin"

	# Make message bundles
	cd "${S}/lib/native_encoded_messagebundles"
	python create_iso88591_bundles.py
	cd "${S}/lib/messagebundles"
	jar -cf MessagesBundles.jar resources totd xml *.properties
}

src_install() {
	java-pkg_dojar "${S}/gui/lib/FrostWire.jar"
	java-pkg_dojar "${S}/lib/jars/other/themes.jar"
	java-pkg_dojar "${S}/lib/jars/id3v2.jar"
	java-pkg_dojar "${S}/lib/messagebundles/MessagesBundles.jar"

# Install resources for Frostwire. Don't let the jars deceive ya :)
# These are directly required, not sure of source atm
	insinto	${PREFIX}
	doins "${S}/gui/xml.war"
	doins "${S}/gui/update.ver"
	doins "${S}/lib/messagebundles/MessagesBundle.properties"
	cd "${D}/usr/share/${PN}"
	ln -s lib/id3v2.jar
	ln -s lib/MessagesBundles.jar
	ln -s lib/themes.jar

# Bundled jars, yeah I know throw up in your mouth some
# but registering them you say, only doing so for launcher
	bjs="clink.jar daap.jar commons-httpclient.jar commons-pool.jar \
		jcraft.jar jdic.jar jl011.jar mp3sp14.jar ProgressTabs.jar \
		tritonus.jar vorbis.jar linux/jdic_stub.jar i18n.jar"
	for bj in ${bjs} ; do
		java-pkg_dojar "${S}/lib/jars/${bj}"
	done

	touch "${D}/${PREFIX}/hashes"

	java-pkg_dolauncher ${PN} \
		--main com.limegroup.gnutella.gui.Main \
		--java_args "-Xms64m -Xmx128m -ea -Dorg.apache.commons.logging.Log=org.apache.commons.logging.impl.NoOpLog" \
		--pwd /usr/share/${PN}

	sizes="16x16 32x32 48x48 64x64"
	for size in ${sizes} ; do
		insinto /usr/share/icons/hicolor/${size}/apps
		doins "${S}/lib/icons/hicolor/${size}/apps/${PN}.png"
	done

	make_desktop_entry frostwire FrostWire
}
