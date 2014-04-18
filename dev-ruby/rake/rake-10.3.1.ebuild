# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rake/rake-10.3.1.ebuild,v 1.1 2014/04/18 14:21:58 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES README.rdoc TODO"

RUBY_FAKEGEM_TASK_TEST=""

inherit bash-completion-r1 ruby-fakegem

DESCRIPTION="Make-like scripting in Ruby"
HOMEPAGE="http://rake.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc"

DEPEND+=" app-arch/gzip"

ruby_add_bdepend "doc? ( dev-ruby/rdoc )
	test? ( >=dev-ruby/hoe-3.7
		virtual/ruby-minitest
		)"

all_ruby_prepare() {
	# Decompress the file. The compressed version has errors, ignore them.
	zcat doc/rake.1.gz > doc/rake.1
}

each_ruby_prepare() {
	case ${RUBY} in
		*jruby)
			# Remove failing test. This works on jruby 1.7, is a
			# known bug on 1.6 and also fails on rake-0.9.6.
			sed -i -e '/test_signal_propagation_in_tests/,/^  end/ s:^:#:' test/test_rake_functional.rb || die
			;;
	esac
}

all_ruby_compile() {
	if use doc; then
		ruby -Ilib bin/rake docs || die "doc generation failed"
	fi
}

each_ruby_test() {
	${RUBY} -Ilib bin/rake || die
}

all_ruby_install() {
	ruby_fakegem_binwrapper rake

	if use doc; then
		pushd html
		dohtml -r *
		popd
	fi

	doman doc/rake.1

	newbashcomp "${FILESDIR}"/rake.bash-completion ${PN}
}
