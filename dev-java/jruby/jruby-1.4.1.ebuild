# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jruby/jruby-1.4.1.ebuild,v 1.7 2013/06/14 02:41:48 patrick Exp $

EAPI="2"
JAVA_PKG_IUSE="doc source test"
inherit eutils java-pkg-2 java-ant-2

MY_PV="${PV/_rc1/RC1}"

DESCRIPTION="Java-based Ruby interpreter implementation"
HOMEPAGE="http://jruby.codehaus.org/"
#SRC_URI="http://jruby.kenai.com/downloads/${PV}/${PN}-src-${MY_PV}.tar.gz"
SRC_URI="http://jruby.org.s3.amazonaws.com/downloads/${PV}/${PN}-src-${MY_PV}.tar.gz"
LICENSE="|| ( CPL-1.0 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="bsf ssl"

CDEPEND=">=dev-java/bytelist-1.0.2:0
	>=dev-java/constantine-0.6:0
	>=dev-java/jline-0.9.94:0
	>=dev-java/joni-1.1.3:0
	>=dev-java/jna-posix-1.0.1:0
	>=dev-java/jvyamlb-0.2.5:0
	>=dev-java/asm-3.2:3
	>=dev-java/jcodings-1.0.4:0
	>=dev-java/jffi-0.7_pre:0.4
	dev-java/jna:0
	dev-java/joda-time:0
	dev-util/jay:0[java]
	dev-java/nailgun:0
	dev-java/jaffl:0
	dev-java/jgrapht:0"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.6"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.6
	bsf? ( dev-java/bsf:2.3 )
	test? (
		dev-java/ant-junit
		dev-java/ant-trax
	)
	!!<dev-ruby/jruby-1.3.1-r1"

PDEPEND="ssl? ( dev-ruby/jruby-openssl )"

# Tests work for ali_bush.  But fail for flameeyes see #282439.
# Tests work for ali_bush inside the ebuild env
# but fail when using vanilla src tarball.
# Restrict tests so we can stablise this package.
RESTRICT="test"

S="${WORKDIR}/${PN}-${MY_PV}"

RUBY_HOME=/usr/share/${PN}/lib/ruby
SITE_RUBY=${RUBY_HOME}/site_ruby
GEMS=${RUBY_HOME}/gems

JAVA_ANT_REWRITE_CLASSPATH="true"
JAVA_ANT_IGNORE_SYSTEM_CLASSES="true"
EANT_GENTOO_CLASSPATH="asm-3 bytelist constantine jay jcodings jffi-0.4 jline \
joda-time joni jna jna-posix jvyamlb nailgun jaffl jgrapht"
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
	epatch "${FILESDIR}/ftype-test-fixes.patch"
	epatch "${FILESDIR}/user-test-fixes.patch"
	epatch "${FILESDIR}"/${PN}-1.4.0-system-jars-r2.patch
	epatch "${FILESDIR}"/${PN}-1.4.0-bindir.patch

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
	rm lib/profile.jar || die

	use bsf && java-pkg_jar-from --into build_lib \
		--build-only bsf-2.3

	if ! use bsf; then
		# Remove BSF test cases.
		cd "${S}/test/org/jruby"
		rm -f test/TestAdoptedThreading.java || die
		rm -f javasupport/test/TestBSF.java || die
		sed -i '/TestBSF.class/d' javasupport/test/JavaSupportTestSuite.java || die
		sed -i '/TestAdoptedThreading.class/d' test/MainTestSuite.java || die
	fi
}

src_compile() {
	eant jar $(use_doc apidocs) $(use bsf && echo "-Dbsf.present") \
		-Djdk1.5+=true
}

src_test() {
	if [ ${UID} == 0 ] ; then
		ewarn 'The tests will fail if run as root so skipping them.'
		ewarn 'Enable FEATURES="userpriv" if you want to run them.'
		return
	fi

	# ali_bush was getting crashes while attempting to run a test.
	# No info about why it crashed seemed to be produced.
	# remove it as temp fix.
	#sed -i -e '/MRI/d' build.xml || die "Failed to sed build.xml"

	# BSF is a compile-time only dependency because it's just the adapter
	# classes and they won't be used unless invoked from BSF itself.
	use bsf && java-pkg_jar-from --into build_lib --with-dependencies bsf-2.3

	# Our jruby.jar is unbundled so we need to add the classpath to this test.
	sed -i "s:java -jar:java -Xbootclasspath/a\:#{ENV['JRUBY_CP']} -jar:g" test/test_load_compiled_ruby_class_from_classpath.rb || die

	ANT_TASKS="ant-junit ant-trax" JRUBY_CP=`java-pkg_getjars ${EANT_GENTOO_CLASSPATH// /,}` JRUBY_OPTS="" eant test -Djdk1.5+=true
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
}
