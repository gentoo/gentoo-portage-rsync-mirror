# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/afm/afm-0.2.2.ebuild,v 1.2 2014/08/11 09:57:05 jer Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A very simple library to read Adobe Font Metrics files"
HOMEPAGE="https://github.com/halfbyte/afm"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/shoulda )"

all_ruby_prepare() {
	sed -i -e "/[Bb]undler/s/^/#/" test/helper.rb || die
}

each_ruby_test() {
	${RUBY} -Ilib:test test/test_afm.rb || die
}
