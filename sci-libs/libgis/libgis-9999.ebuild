# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://lug.rose-hulman.edu/proj/libgis"
EGIT_BOOTSTRAP="gtkdocize && eautoreconf"

EAPI=1
inherit autotools gnome2 git

DESCRIPTION="Virtual Globe library"
HOMEPAGE="http://lug.rose-hulman.edu/wiki/Libgis"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND=">=net-libs/libsoup-2.26
	dev-libs/glib:2
	x11-libs/gtk+:2
	x11-libs/gtkglext"

# gtk-doc-am needed to eautoreconf
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	doc? ( dev-util/gtk-doc )"

DOCS="ChangeLog README TODO"
