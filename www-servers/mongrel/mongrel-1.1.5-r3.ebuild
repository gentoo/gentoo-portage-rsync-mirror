# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/mongrel/mongrel-1.1.5-r3.ebuild,v 1.7 2013/01/15 05:15:20 zerochaos Exp $

EAPI="2"

# ruby19 → extension does not build, so there is no way to get this to
# work for now
USE_RUBY="ruby18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README TODO"

RUBY_FAKEGEM_GEMSPEC="mongrel.gemspec"

inherit multilib ruby-fakegem

DESCRIPTION="A small fast HTTP library and server that runs Rails, Camping, and Nitro apps"
HOMEPAGE="http://mongrel.rubyforge.org/"

LICENSE="|| ( mongrel GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="ruby_targets_jruby? ( >=virtual/jdk-1.5 )"

ruby_add_rdepend ">=dev-ruby/daemons-1.0.3
	>=dev-ruby/gem_plugin-0.2.3"

# Only useful with Ruby 1.8 as it's not used/useful with Ruby 1.9 or JRuby
USE_RUBY=ruby18 ruby_add_rdepend ">=dev-ruby/fastthread-1.0.1"

ruby_add_bdepend test virtual/ruby-test-unit

all_ruby_prepare() {
	# This package is no longer in our tree and it is not needed for any
	# supported ruby version.
	sed -i -e '/cgi_multipart_eof_fix/d' mongrel.gemspec || die
}

each_ruby_compile() {
	case ${RUBY} in
		*jruby)
			# There is no script to build the JRuby extension so we're
			# going to do it manually :(
			pushd ext/http11_java &>/dev/null
			find . -name '*.java' | xargs javac -source 1.5 -target 1.5 -cp $(java-config -d -p jruby) \
				|| die "failed to build java source"
			find . -name '*.class' | xargs jar cf http11.jar \
				|| die "failed to create http11.jar"
			popd &>/dev/null

			# Move it here to avoid special-casing the test and
			# install phases.
			cp ext/http11_java/http11.jar lib/ || die "unable to copy http11.jar"
			;;
		*)
			pushd ext/http11 &>/dev/null
			${RUBY} extconf.rb || die "extconf failed"
			emake || die "emake failed"
			popd &>/dev/null

			# Move it here to avoid special-casing the test and
			# install phases.
			cp ext/http11/http11$(get_modname) lib/ || die "unable to copy http11 shared object"
			;;
	esac
}

each_ruby_test() {
	${RUBY} -S testrb -I lib:ext/http11_java -a test -x test_command || die "tests failed"
}
