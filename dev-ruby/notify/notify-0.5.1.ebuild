# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/notify/notify-0.5.1.ebuild,v 1.1 2013/04/13 06:19:25 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_RECIPE_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md sample.rb"

inherit ruby-fakegem

DESCRIPTION="A function to notify on cross platform"
HOMEPAGE="http://github.com/jugyo/notify"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="x11-libs/libnotify"
