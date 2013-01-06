# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jruby/jruby-1.5.6.ebuild,v 1.3 2011/10/19 01:25:10 fordfrog Exp $

EAPI="2"
JAVA_PKG_IUSE="doc source test"
inherit eutils java-pkg-2 java-ant-2

MY_PV="${PV/_rc1/RC1}"

DESCRIPTION="Java-based Ruby interpreter implementation"
HOMEPAGE="http://jruby.codehaus.org/"
SRC_URI="http://jruby.org.s3.amazonaws.com/downloads/${PV}/${PN}-src-${PV}.tar.gz"
LICENSE="|| ( CPL-1.0 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="bsf ssl"

CDEPEND=">=dev-java/bytelist-1.0.6:0
	>=dev-java/constantine-0.6:0
	>=dev-java/jline-0.9.94:0
	>=dev-java/joni-1.1.3:0
	>=dev-java/jnr-posix-1.1.3:0
	>=dev-java/jnr-netdb-1.0:0
	>=dev-java/jvyamlb-0.2.5:0
	>=dev-java/asm-3.2:3
	dev-java/jcodings:0
	>=dev-java/jffi-0.7_pre:0.4
	dev-java/joda-time:0
	dev-util/jay:0[java]
	dev-java/nailgun:0
	dev-java/jaffl:0
	dev-java/jgrapht:0
	dev-java/ant-core:0
	dev-java/bsf:2.3"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.6"

DEPEND="${CDEPEND}
	virtual/jdk:1.6
	test? (
		dev-java/ant-junit4:0
		dev-java/ant-trax:0
		dev-java/junit:4
		java-virtuals/jdk-with-com-sun
		dev-java/commons-logging:0
		dev-java/xalan:0
		>=dev-java/jna-posix-1.0.1:0
	)
	!!<dev-ruby/jruby-1.3.1-r1"

PDEPEND="ssl? ( dev-ruby/jruby-openssl )"

# Tests fail.
# Need to stop injecting jar's into classpath.
RESTRICT="test"

S="${WORKDIR}/${PN}-${MY_PV}"

RUBY_HOME=/usr/share/${PN}/lib/ruby
SITE_RUBY=${RUBY_HOME}/site_ruby
GEMS=${RUBY_HOME}/gems

JAVA_ANT_REWRITE_CLASSPATH="true"
JAVA_ANT_IGNORE_SYSTEM_CLASSES="true"
EANT_GENTOO_CLASSPATH="ant-core asm-3 bsf-2.3 bytelist constantine jay \
jcodings jffi-0.4 jline constantine \
joda-time joni jnr-posix jnr-netdb jvyamlb nailgun jaffl jgrapht"
EANT_NEEDS_TOOLS="true"

pkg_setup() {
	java-pkg-2_pkg_setup

	local fail

	for directory in "${GEMS}" "${SITE_RUBY}"; do
		if [[ -L ${directory} ]]; then
			eerror "${directory} is a symlink. Please do the following to resolve the situation:"
			echo 'emerge -an app-portage/gentoolkit'
			echo 'equery -qC b '"${directory}"' | sort | uniq | sed s/^/=/ > ~/jruby.fix'
			echo 'emerge -1C $(< ~/jruby.fix)'
			echo "rm ${directory}"
			echo 'emerge -1 $(< ~/jruby.fix)'
			echo 'rm ~/jruby.fix'

			eerror "For more information, please see http://bugs.gentoo.org/show_bug.cgi?id=302187"
			fail="true"
		fi
	done

	if [[ -n ${fail} ]]; then
		die "Please address the above errors, then run emerge --resume"
	fi
}

java_prepare() {
	epatch "${FILESDIR}"/${PN}-1.5.0-system-jars.patch
	epatch "${FILESDIR}/1.5.1/build.xml.patch"
	epatch "${FILESDIR}/1.5.1/testfixes.patch"

	# We don't need to use Retroweaver. There is a jarjar and a regular jar
	# target but even with jarjarclean, both are a pain. The latter target
	# is slightly easier so go with this one.
	sed -r -i \
		-e 's/maxmemory="128m"/maxmemory="192m"/' \
		-e "/RetroWeaverTask/d" \
		-e "/<zipfileset .+\/>/d" \
		build.xml || die

	sed -i -e '/Arndt/d' src/org/jruby/RubyBigDecimal.java

	# Delete the bundled JARs but keep invokedynamic.jar.
	# No source is available and it's only a dummy anyway.
	find build_lib -name "*.jar" ! -name "jsr292-mock.jar" -delete || die

	# change some defaults for Gentoo to work properly
	cat - >> src/org/jruby/jruby.properties <<EOF
jruby.bindir = /usr/bin
EOF
}

src_compile() {
	local flags=""
	use bsf && flags="-Dbsf.present=true"

	eant jar $(use_doc apidocs) -Djdk1.5+=true ${flags}
}

src_test() {
	if [ ${UID} == 0 ] ; then
		ewarn 'The tests will fail if run as root so skipping them.'
		ewarn 'Enable FEATURES="userpriv" if you want to run them.'
		return
	fi
	# Our jruby.jar is unbundled so we need to add the classpath to this test.
	sed -i "s:java -jar:java -Xbootclasspath/a\:#{ENV['JRUBY_CP']} -jar:g" test/test_load_compiled_ruby_class_from_classpath.rb || die
	sed -i "s@:refid => 'build.classpath'@:path =>\"#{ENV['JRUBY_CP']}:lib/jruby.jar\"@g" \
		rakelib/commands.rake || die
	#sed -i "s@:refid => 'test.class.path'@:path => \"#{ENV['JRUBY_CP']}@g" \
	#	rakelib/commands.rake || die

	#bsf optionally depends on jruby, which means that the previously
	#installed jruby will be added to classpath, nasty things will happen.
	local cpath=`java-pkg_getjars ${EANT_GENTOO_CLASSPATH// /,},junit-4`
	cpath="$(echo ${cpath} | sed -e "s_${ROOT}/usr/share/jruby/lib/jruby.jar:__g")"
	cpath="${cpath}:$(java-pkg_getjars --build-only commons-logging,xalan)"
	EANT_GENTOO_CLASSPATH=""

	local flags=""
	use bsf && flags="-Dbsf.present=true"

	#Clear RUBYOPT
	export RUBYOPT=""
	export JRUBY_CP="${cpath}"
	ANT_TASKS="ant-junit4 ant-trax" \
		JRUBY_OPTS="" eant test -Djdk1.5+=true -Djruby.bindir=bin \
		-Dgentoo.classpath="${cpath}" ${flags}
}

src_install() {
	local bin

	java-pkg_dojar lib/${PN}.jar
	dodoc README docs/{*.txt,README.*} || die

	use doc && java-pkg_dojavadoc docs/api
	use source && java-pkg_dosrc src/org

	# We run the sed here in install so that we don't get the wrong
	# data during the test phase!
	sed \
		-e '/++ebuild-cut-here++/, /--ebuild-cut-here--/ d' \
		-e '/^JRUBY_HOME=/s:=:=/usr/share/jruby:' \
		bin/jruby > "${T}"/jruby

	dobin "${T}"/jruby "${S}"/bin/j{irb{,_swing},rubyc} || die

	insinto "${RUBY_HOME}"
	doins -r "${S}"/lib/ruby/{1.8,1.9,site_ruby} || die

	# Remove all the references to RubyGems as we're just going to
	# install it through dev-ruby/rubygems.
	find "${D}${RUBY_HOME}" -type f \
		'(' '(' -path '*rubygems*' -not -name 'jruby.rb' ')' -or -name 'ubygems.rb' -or -name 'datadir.rb' ')' \
		-delete || die
}

pkg_postinst() {
	ewarn "If you're updating from <=jruby-1.4.0, you're going to get errors related"
	ewarn "to gentoo.rb load failure."
	ewarn "This is due to a stray definition of JRUBY_OPTS variable from the previous ebuilds."
	ewarn "To solve the problem, either login in a new shell, use 'env -i ${SHELL} --login'"
	ewarn "or explicitly unset the variable before running jruby."
	ewarn ""
	ewarn "Currently this package introduces issues/bugs that are not present within upstream"
	ewarn "releases.  Therefore if you are wanting a stable build of jruby please do not"
	ewarn "use this package."
}
